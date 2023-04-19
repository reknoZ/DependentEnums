# DependentEnums

This is a simple Swift and SwiftUI example of two related enums, League and Team, being used in separate pickers.

Choosing a league in one picker determines which teams are available to choose from in the second picker.

Both the league and team variables are declared as Optional, so that the first item in the list ("Pick a League" or "Pick a Team") is not an actual item in the enum.  When a new league is selected, the team variable is set to nil, because if it was previously set to a team from a different league, that selection would no longer be valid. IOW, you can't pick Real Madrid if you've chosen Premier League.

I created this in response to tweets posted by @SwiftUI_newbie on 17 April 2023.
