SimpleSchema.messages
  cardInvalidMonth: "Invalid Card Month"
  cardInvalidYear: "Invalid Card Year"
  cardExpired: "Expired Card"

isCardDateValid = (month, year) ->
  currentDate = new Date()
  currentMonth = currentDate.getMonth()
  currentYear = currentDate.getFullYear()
  currentYearShort = parseInt(currentYear.toString().substr(2,2))

  if year > currentYearShort
    return true
  else if year == currentYearShort and month >= currentMonth 
    return true

@CheckoutSchema = new SimpleSchema
  cardMonth:
    type: Number
    custom: ->
      unless isCardDateValid @value, @field("cardYear").value
        return "cardExpired"
      unless @value >= 1 && @value <= 12
        return "cardInvalidMonth"

  cardYear:
    type: Number
    custom: ->
      unless isCardDateValid @field("cardMonth").value, @value
        return "cardExpired"
      unless @value.toString().length == 2
        return "cardInvalidYear"