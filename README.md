# ossu
The OSSU curriculum is a complete education in computer science using online materials. It's for those who want a proper, well-rounded grounding in concepts fundamental to all computing disciplines, and for those who have the discipline, will, and (most importantly!) good habits to obtain this education largely on their own, but with support from a worldwide community of fellow learners. The courses themselves are among the very best in the world, often coming from Harvard, Princeton, MIT, etc., but specifically chosen to meet the following criteria.

# Simple Data - edX, University of Brtish Columbia
https://www.edx.org/course/how-code-simple-data-ubcx-htc1x
The goal of the Simple Data class is learn techniques to
1)  produce programs with consistent structure that are easy to modify later
2)  make programs more reliable by building tests as an integral part of the programming process

## Final project
Developed a the Game Space invaders by strictly following the **test-driven** and **clean code** approach taught in the course.

In particular, I payed attention to
1) Defined the problem domain making sketches.
2) Defined constants.
3) Defined and documented variables (signature, purpose, examples, stub) 
   and created corresponding function templates.
4) Defined the main function.
5) Defined functions and helpers by paying attention to the "one-task-per-function"- rules.
6) Strictly implemented tests before each function.

**Additional learnings:** DrRacket, Beginning Student Language (BSL), Visual Programming, Functional Programming, Natural Recursion, Primitive Data types, Arbitrary Sized Data Types, Structs.

### Play Space Invaders:
1) Download DrRacket: https://racket-lang.org/download/
2) Download space-invaders-starter.rkt from this repo. 
3) Choose Beginning Student Language from the Menu in DrRacket.
3) Click on run in the upper right corner to check if tests pass.
4) To play type (main G0) in the console and hit enter.
5) Press let-key or right-key to move. Press space-key to shoot. 

# Complex Data - edX, University of Brtish Columbia
https://courses.edx.org/courses/course-v1:UBCx+HtC2x+2T2017/courseware/d4b5b9454a3e47689c866b557162d73d/044aa02b1c6a4911ac519b11d2459526/1?activate_block_id=block-v1%3AUBCx%2BHtC2x%2B2T2017%2Btype%40vertical%2Bblock%400bcddf7c9bdc4df0b22b70f1f81ce6ba
The Complex Data class builds-up on the Simple Data class and teaches techniques on complex data structures. The course follows a formalized, structural approach to (functional) programming which heavily emphasizes test-driven development and clean function design. 

## The following topics were covered:

- Mutually referential data and function design (arbitrary-arity trees)
- Backtracking search
- Search algorithms
- Determing cases using a cross-product table with complex data structures
- Local variables, lexical scoping and encapsulation
- Abstraction
- Closures
- Generative Recursion
- Lambda Expressions
- Tail Recursion
- Accumulators: context-preserving accumulators, result-so-far accumulators (rsf) and worklist accumulators (todo)
- Graph structures
- Blending templates for different data types

## Final project
The final project (complex-data/ta-solver-starter.rkt) wraps up the learning of the Simple Data and Complex Data courses. 
It involed two complex tasks: 
1) To write a Twitter-like program working on graph structures
2) A program to generate a schedule for teachers which matches teachers and their availability under certain constraints.

**Additional learnings:** 
- DrRacket, Advanced Student Language (ASL), Functional Programming
- strong focus on clean and test-driven function design

# Programming Languages, Part A by University of Washington

Basic concepts of programming languages, with a strong emphasis on functional programming. The course uses the language ML. 
https://www.coursera.org/learn/programming-languages

## Learnings
- functional programming concepts
- statically vs. dynamically typed languages
- shadowing, lexical scope, closures
- custom / compound data types (each of, one of types)
- pattern matching
- recursion and tail recursion
- higher-order functions, map, filter fold
- function composition
- currying and partial application of functions
- mutable data types in functional programming
- callbacks
- type inference and polymorhic typing
- mutual recursion
- module management with signatures
- privacy
- equivalence 