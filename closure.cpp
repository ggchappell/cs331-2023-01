// closure.cpp
// Glenn G. Chappell
// 2023-02-03
//
// For CS 331 Spring 2023
// C++11 Closures

#include <iostream>
using std::cout;
using std::endl;
using std::cin;
#include <functional>
using std::function;


// make_multiplier
// Return a function object (a closure) that multiplies by the given k.
function<int(int)> make_multiplier(int k)
{
    auto mult = [=](int x)
    {
        return k * x;
    };

    // Return value is a function object, which wraps the lambda
    // function defined above. This object is a closure; it *captures* a
    // portion of the environment in which it is defined. The "[=]"
    // above means that the closure captures a copy of every variable it
    // uses. Replace this with "[k]" to specify that only a copy of k
    // should be captured. Replace with "[&k]" to capture k by reference
    // -- a very bad idea in this particular case, as k is a local
    // variable of function make_multiplier.

    return mult;
}


// userPause
// Wait for user to press ENTER: read all chars through first newline.
void userPause()
{
    std::cout.flush();
    while (std::cin.get() != '\n') ;
}


// Main program
// Demonstrate make_multiplier by creating some closures and using them.
int main()
{
    cout << "Demonstration of Closures in C++ "
         << "(2011 Standard and later)" << endl;
    cout << "See the source code for details." << endl;
    cout << endl;

    auto times2 = make_multiplier(2);
    auto triple = make_multiplier(3);
    auto times7 = make_multiplier(7);

    cout << "300 times 2 is " << times2(300) << "." << endl;
    cout << "25 tripled is " << triple(25) << "." << endl;
    cout << "10 times 7 is " << times7(10) << "." << endl;
    cout << endl;

    // Wait for user
    cout << "Press ENTER to quit ";
    userPause();
}

