# MP Report

## Student information

- Name: Matthew Thornton
- AID: A20469741

## Self-Evaluation Checklist

Tick the boxes (i.e., fill them with 'X's) that apply to your submission:

- [X] The app builds without error
- [X] I tested the app in at least one of the following platforms (check all
      that apply):
  - [ ] iOS simulator / MacOS
  - [X] Android emulator
- [X] Users can register and log in to the server via the app
- [X] Session management works correctly; i.e., the user stays logged in after
      closing and reopening the app, and token expiration necessitates re-login
- [X] The game list displays required information accurately (for both active
      and completed games), and can be manually refreshed
- [X] A game can be started correctly (by placing ships, and sending an
      appropriate request to the server)
- [X] The game board is responsive to changes in screen size
- [X] Games can be started with human and all supported AI opponents
- [X] Gameplay works correctly (including ship placement, attacking, and game
      completion)

## Summary and Reflection

I believe I have almost everything working correctly, the only thing that's kind of wonky is the row labels on the game screen. I couldn't quite figure out how to get it line up with the grid on different screen sizes. Also, when you say token expiration *necessitates* re-login. It does. But, I'm not sure if I was supposed to force the user back to the login screen, but it does necessitate a re-login in the sense that the app is unusable without a fresh access token. I used FutureBuilder for displaying the games on the main screen as well as on the game screen for displaying the appropriate icons promptly after a certain action. For the refresh I just did a blank setState since the server contains all the information I need anyway. 

This project was awesome, working with the REST api, the capability to play my finished game with other students, seeing how the frontend UI elements and the backend HTTP server interact with each other. I thoroughly enjoyed working on this assignment and will more than likely put this on my resume. The only thing I didn't enjoy was having to run the app on an AVD, those things tend to be painstakingly slow and prone to errors. I'm not sure what platform the project was being run on in the video demonstration, I assume that was MacOS. I would've loved to work with a platform that fast. I am now considering getting a Mac. 
