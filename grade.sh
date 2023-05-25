CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'
if [[ -e student-submission ]] 
then
    cp student-submission/ListExamples.java grading-area
    cp TestListExamples.java grading-area
    cd grading-area
    javac -cp ".;../lib/hamcrest-core-1.3.jar;../lib/junit-4.13.2.jar" TestListExamples.java ListExamples.java
    if [[ $? == 1 ]]
    then
        echo "Compile Error"
        exit 1
    fi
    java -cp ".;../lib/junit-4.13.2.jar;../lib/hamcrest-core-1.3.jar" org.junit.runner.JUnitCore TestListExamples > grader.txt
    NO_FAILS=`grep "OK" grader.txt`
    FAILS=`grep "Tests run" grader.txt`
    echo $NO_FAILS
    echo $FAILS
    # If one of the tests fails
    if [ -z $NO_FAILS ] 
    then
        echo Works1
    # If none of the tests fail  
    else
        echo Works2
    fi
    # If all the tests pass
    
    RESULT=`grep "Tests run" grader.txt`
    TESTS_RAN=${RESULT:11:1}
    TESTS_FAIL=${RESULT:25:1}
    GRADE="$(($TESTS_RAN-$TESTS_FAIL))"
    echo "You're grade is:" $GRADE/$TESTS_RAN
fi



# Draw a picture/take notes on the directory structure that's set up after
# getting to this point

# Then, add here code to compile and run, and do any post-processing of the
# tests
