# MorseXlate
translates text to code and  then a wav file

There was a requiremtnt to apply for a job that wanted a text to morse code sample 

i did that but then went ahead and had it generate a wav that could be played 

currently the audio is generated by anding a 440hz sin wave with the value of the Keyset and it provides a very authentic tone

It does this in an ineffecient way. to further improve i would generate either just dits dahs or whole charachters store those to disk and then just sequence those to play the tone.  this would eliminate the lockup that occurs when you tell it to convert. 

video of it in action:
https://www.youtube.com/watch?v=GeANgR15gl8
