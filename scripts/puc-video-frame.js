/**
 * Just a workaround to make iframe fill the entire view, improving UX
 * Without the needed of going to full screen.
 */

const iframe = document.querySelectorAll('p iframe')
iframe[0].style.width = '100%'
iframe[0].style.height = '90vh'