{
  num = $0 + 0
  if (num <= 0) {
    print "Error: Only positive numbers are allowed"
    exit 1
  }
  steps = 0
  while (num > 1) {
    steps++
    num = num % 2 == 0 ? num / 2 : num * 3 + 1
  }
  print steps
}
