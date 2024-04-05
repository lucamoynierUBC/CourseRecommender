% Course Includes Name, Code, Pre-reqs, Co-reqs
course('ASIA 371', 'Foundations of Chinese Thought', 3, [], 'Chinese thought from its beginnings until the Han dynasty (206 BCE to 220 CE) in its historical and cultural contexts. Includes, among others: Confucius; Mo Zi; the Legalists/Authoritarians; Zhuang Zi; the Lao Zi book.').
course('ASIA 378', 'Philosophical Wisdom of Early India', 3, [], 'Epistemological and ontological thought from the Vedic period to the period of the rise of philosophical schools or systems Philosophy in the Mahabharata, Gita; early Buddhist and Jain views on knowledge and reality; views on language.').
course('ASIA 470', 'Comparative Conceptions of the Self', 3, [], 'Ways in which the "self" has been portrayed in eastern and western religious traditions. Thinkers to be considered include Aristotle, Mencius, Freud, Xunzi (Hsün-tzu), Nietzsche, and Zhuangzi (Chuang-tzu).').
course('ASTU 402', 'Living Language: Science and Society', 3, [4], 'Multidisciplinary course in which students, individually and in groups, examine, integrate and apply subject-specific knowledge through the lens of language and the framework of the language sciences, with a focus on themes of real-world importance.').
course('BIOL 371', 'Principles of Neurobiology I', 3, ['BIOL 200'], 'Introduction to the structure and function of the nervous system, excitable membranes, and synaptic signaling using representative vertebrate and invertebrate species. Please consult the Faculty of Science Credit Exclusion Lists: https://vancouver.calendar.ubc.ca/faculties-colleges-and-schools/faculty-science/bachelor-science/credit-exclusion-lists').
course('BIOL 372', 'Principles of Neurobiology II', 3, ['BIOL 371'], 'Examination of the neural systems underlying sensation, action, and complex behaviours using representative vertebrate and invertebrate species. Please consult the Faculty of Science Credit Exclusion Lists: https://vancouver.calendar.ubc.ca/faculties-colleges-and-schools/faculty-science/bachelor-science/credit-exclusion-lists').
course('CPSC 304', 'Introduction to Relational Databases', 3, ['CPSC 221'], 'Overview of database systems, ER models, logical database design and normalization, formal relational query languages, SQL and other commercial languages,data warehouses, special topics.'). 
course('CPSC 310', 'Introduction to Software Engineering', 4, ['CPSC 213, CPSC 221'], 'Specification, design, validation, evolution and construction of modern software systems, within the context of socially and professionally relevant domains such as ethics, intellectual property, and information security.').
course('CPSC 311', 'Definition of Programming Languages', 3, ['CPSC 210'], 'Comparative study of advanced programming language features. Statement types, data types, variable binding, parameter passing mechanisms. Methods for syntactic and semantic description of programming languages.'). 
course('CPSC 312', 'Functional and Logic Programming', 3, ['CPSC 210'], 'Principles of symbolic computing, using languages based upon first-order logic and the lambda calculus. Algorithms for implementing such languages. Applications to artificial intelligence and knowledge representation.'). 
course('MATH 302', 'Introduction to Probability', 3, ['MATH 200'], 'Basic notions of probability, random variables, expectation and conditional expectation, limit theorems.').
course('MATH 303', 'Introduction to Stochastic Processes', 3, ['MATH 302'], 'Discrete-time Markov chains, Poisson processes, continuous time Markov chains, renewal theory.').
course('MATH 340', 'Introduction to Linear Programming', 3, ['MATH 221'], 'Linear programming problems, dual problems, the simplex algorithm, solution of primal and dual problems, sensitivity analysis. Additional topics chosen from: Karmarkars algorithm, non-linear programming, game theory, applications.').
course('MATH 344', 'Mathematical Game Theory', 3, ['MATH 223'], 'Introduction to mathematical game theory and its applications.').
course('MATH 443', 'Graph Theory', 3, ['CPSC 121'], 'Introductory course in mostly non-algorithmic topics including: planarity and Kuratowskis theorem, graph colouring, graph minors, random graphs, cycles in graphs, Ramsey theory, extremal graph theory. Proofs emphasized. Intended for Honours students.').
course('MECH 421', 'Mechatronics System Instrumentation', 4, ['MECH 366', 'MECH 420'], 'Architecture of mechatronics devices; integration of mechanical, electronics, sensors, actuators, computer and real time software systems; PLC and PC based systems; discrete and continuous automation system design.').
course('MUSC 320', 'Computer Music', 3, ['MUSC 319'], 'The study of computer applications to music, focusing on digital synthesis techniques and languages, methods of algorithmic composition, and the design of music editors.').
course('NSCI 303', 'Foundations of Computational Neuroscience', 3, ['NSCI 201'], 'Foundations of computational neuroscience: neural modelling, simple neural networks, models of Hebbian learning, models of learning, clustering and classification.').
course('PHIL 320', 'Logic: Metatheory and Computability', 3, ['PHIL 220'], 'Continuation of PHIL 220. A system of deduction for predicate logic is selected for further study. Completeness of this system and other metatheoretic results are proved. Other topics include computability, recursive function theory, incompleteness and decidability.').
course('PHIL 321', 'Induction, Decision and Game Theory', 3, ['PHIL 220'], 'Formal methods relevant to probabilistic and inductive reasoning. Decision theory, game theory, axiomatic probability theory and its interpretations, belief dynamics, simulation and modelling.').

% prereq(C, X) is true if C is a course and is a pre-requisite of another course
prereq(Prereq, Course) :- course(Course, _, _, Prereqs, _), member(Prereq, Prereqs).

% TODO:
% Low importance: Add more courses
% Create queries
% Understand prolog !!!!
% Parse courses content
stream(cpsc).
stream(ling). 
stream(phil). 
stream(psyc). 


dept('CPSC').
dept('PSYC').
dept('PHIL').
dept('LING').

car([X|_], X).

parse_course(Course, X) :- course(Course, _, _, _, _), split_string(Course, "\s", "\s", L), car([X|_], X).

% nonpsyc(Course) :- not(course(atom_concat('PSYC ', _), _, _, _, _)).
 
% noncpsc(Course) :- not(course(atom_concat('CPSC ', _), _, _, _, _)).

parse_department(Course, Dept) :- course((c, d), _, _, _, _), split_string(Course, "\s", "\s",  L). 

% psyc checks whether a given course is a psychology course.
% non_psyc checks whether a given course is NOT a psychology course.
psyc(course(N,_,_,_,_)) :- split_string(N, "\s", "\s",  L), member("PSYC", L).
non_psyc(course(N,_,_,_,_)) :- \+ psyc(course(N,_,_,_,_)).

% phil checks whether a given course is a philosophy course.
% non_phil checks whether a given course is NOT a philosophy course.
phil(course(N,_,_,_,_)) :- split_string(N, "\s", "\s",  L), member("PHIL", L).
non_phil(course(N,_,_,_,_)) :- \+ phil(course(N,_,_,_,_)).

% ling checks whether a given course is a linguistics course.
% non_ling checks whether a given course is NOT a linguistics course.
ling(course(N,_,_,_,_)) :- split_string(N, "\s", "\s",  L), member("LING", L).
non_ling(course(N,_,_,_,_)) :- \+ ling(course(N,_,_,_,_)).

% cpsc checks whether a given course is a computer science course.
% non_cpsc checks whether a given course is NOT a computer science course.
cpsc(course(N,_,_,_,_)) :- split_string(N, "\s", "\s",  L), member("CPSC", L).
non_cpsc(course(N,_,_,_,_)) :- \+ cpsc(course(N,_,_,_,_)).

% four_cpsc checks whether a given course is a fourth-year computer science course.
four_cpsc(course(N,_,_,_,_)) :-
    cpsc(course(N,_,_,_,_)), 
    split_string(N, "\s", "\s",  L), 
    get_course_num(X,L), 
    atom_chars(X, ['4'|_]).

% get_course_num checks whether X is the last element of a list
% used to obtain the course number from a parsed course code
get_course_num(X,[X]).
get_course_num(X, [_|Z]) :- get_course_num(X, Z).