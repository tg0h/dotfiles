// generates an sql in clause with the input

// IN:
// 123
// 456

// OUT: ('123','456')


// Called first with entire text document
// function pre(text) {
//   // do something with text
//   // return '(' + text;
// }

function perLine(lineOfText, lineNumber) {
  // do something with the line of text
  // and its lineNumber
  return '\'' + lineOfText + '\',';
}

// Called last with entire text document as modified by you
function post(text) {
  // do something with text
  // n = text.lastIndexOf(',');

  // remove the last , from the text string
  text = text.slice(0, -1)

  return '(' + text + ')';
}
