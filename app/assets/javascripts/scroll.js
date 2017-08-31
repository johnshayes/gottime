function scrollLastMessageIntoView() {
  const messages = document.querySelectorAll('.message');
  if (typeof messages[0] !== 'undefined' && messages[0] !== null) {
    const lastMessage = messages[messages.length - 1];
    lastMessage.scrollIntoView();
  }
}
