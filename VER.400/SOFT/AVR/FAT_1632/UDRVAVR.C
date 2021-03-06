
#include <platform.h>
#include "uartdrv.h"

#define BRATE_FACT      ((FOSC / (16L * BRATE)) - 1L)
#define BRATE_VAL       (FOSC / (16 * (BRATE_FACT + 1)))
#define BRATE_MIN       (BRATE - ((BRATE * BRATE_TOL) / 100))
#define BRATE_MAX       (BRATE + ((BRATE * BRATE_TOL) / 100))

#if (BRATE < BRATE_MIN) || (BRATE > BRATE_MAX) || (BRATE_FACT > 0xFF)
  #error Correct Baud Rate can not be set. Change BRATE or FOSC.
#endif

#define RSBUF_MASK      (RSBUF_SIZE - 1)

#if (RSBUF_SIZE & RSBUF_MASK)
  #error UART RX buffer size is not a power of 2
#endif

// Ctrl bits
#define RXCIE   7
#define RXEN    4
#define TXEN    3
// RX Bit in Port D
#define RX_PIN  0
// Status bits
#define UDRE    5

// Static data
STATIC               UINT8   RSBuf[RSBUF_SIZE];
STATIC      VOLATILE UINT8   RSRd;   /* Read pointer                             */
STATIC      VOLATILE UINT8   RSWr;   /* Write pointer                            */


// Returns the number of characters available in the input buffer.
UINT8  inp_status( VOID )
{
  return (UINT8) (RSRd ^ RSWr);  //if they are different then return non Zero
}

// Flush the input buffer.
VOID   inp_flush( VOID )
{
  inp_disable();
  RSRd = RSWr = 0;
  inp_enable();
}

// Program initialization:
VOID   init_comm( VOID )
{
  __port_or( PORTD, (1<<RX_PIN) );                      // Internal Pull-Up RXD
  __outp( UBRR0, BRATE_FACT );                          // Baud Rate factor
  __outp( UCSR0B, ((1<<RXCIE) + (1<<RXEN) + (1<<TXEN)) );
  inp_flush();
}

//
VOID   uninit_comm( VOID )
{
  // Nothing to do
}

VOID     inp_disable ( VOID )
{
  __port_and( UCSR0B, ~(1<<RXEN) );                           //
}

VOID     inp_enable  ( VOID )
{
  __port_or( UCSR0B, (1<<RXEN) );                           //
}

// Return a character from the input
// buffer. Assumes you have called
// inp_status() to see if theres any characters to get.
UINT8  inp_char( VOID )
{
  RSRd = (RSRd + 1) & RSBUF_MASK;
  return RSBuf[RSRd];
}

// Output the character to the serial port. This is not buffered
// or interrupt driven.
VOID   outp_char( UINT8 c )
{
  loop_until_bit_is_set( UCSR0A, UDRE );   // wait for TX empty
  __outp( UDR0, c );
}

//----------------------------------------------------------------
// Function :   SIO_RXint
// Notes    :
// History  :
//----------------------------------------------------------------

#ifdef __IAR__
interrupt [UART0_RX_vect] VOID SIO_RXint ( VOID )
#endif
#ifdef __GNU__
SIGNAL( SIG_UART_RECV )
#endif
{
  REGISTER UINT8 tmp;
  REGISTER UINT8 data;

  data = __inp( UDR0 );

  tmp = (RSWr + 1) & RSBUF_MASK;

  if( tmp != RSRd)
  {
    RSWr = tmp;
    RSBuf[tmp] = data;
  }
}
//      End


