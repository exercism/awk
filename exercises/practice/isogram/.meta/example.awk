{
  print isIsogram($0)
}

function isIsogram(string) {
  gsub(/[^a-zA-Z]+/, "", string)
  string = tolower(string)
  split(string, chars, "")
  for (i in chars) {
    if (unique_chars[chars[i]] == 1) {
      return "false"
    }
    unique_chars[chars[i]] = 1
  }
  return "true"
}
