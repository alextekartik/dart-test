# Show dart2js bug

Runnning test the following way works fine

    pub run test -p vm
    pub run build_runner test -- -p chrome
    
Running it this way fails
    
    pub run test -p chrome
    pub run build_runner test -r -- -p chrome