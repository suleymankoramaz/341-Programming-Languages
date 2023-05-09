% knowledge base
%For Adding new student,room,course
:- dynamic(student/3).
:- dynamic(room/3).
:- dynamic(course/4).
:- dynamic(instructor/3).
:- style_check(-singleton).


%room(room_id,capacity,[equipment]).
room(r01,30,[projector,smart,handcp,no]).
room(r02,25,[projector,no]).
room(r03,35, [projector,handcp,no]).
room(r04,40, [smart,handcp,no]).
room(r05,50,[smart,no]).


%occupied(course,room,hours).
occupied(course101,r03,9).
occupied(course101,r03,10).
occupied(course102,r01,8).
occupied(course104,r03,13).
occupied(course102,r01,10).
occupied(course103,r02,11).
occupied(course102,r01,9).
occupied(course104,r03,12).
occupied(course106,r01,10).
occupied(course105,r04,12).
occupied(course103,r02,8).
occupied(course106,r01,15).
occupied(course104,r03,9).
occupied(course103,r02,14).


%course(course_id,capacity,instructor_id,[needs]).
course(course101,13,instructor01,[handcp]).
course(course102,25,instructur02,[smart,projector]).
course(course103,16,instructor03,[projector]).
course(course104,9 ,instructor02,[handcp,projector]).
course(course105,15,instructor01,[smart]).
course(course106,18,instructur03,[handcp,smart,projector]).


%instructor(instructor_id,[given courses],[prefers]).
instructor(instructor01,[course101,course105],[projector]).
instructor(instructor02,[course104],[projector,smart]).
instructor(instructor03,[course103],[smart]).


student(19010401,[course101],no).
student(19010402,[course103,course106],handcp).
student(19010403,[course104,course106],no).
student(19010404,[course102],no).
student(19010405,[course101,course102],handcp).
student(19010406,[course103],handcp).
student(19010407,[course105,course104],no).

add_student(ID,Courses,Needs):-
    \+student(ID,_,_),
    assertz(student(ID,Courses,Needs)).
%For Adding room
add_room(ID,Capacity,Equipments):-
    \+room(ID,_,_),
    assertz(room(ID,Capacity,Equipments)).
%For Adding Course
add_course(ID,Capacity,InstructorID,Needs):-
    \+course(ID,_,_,_),
    assertz(course(ID,Capacity,InstructorID,Needs)).

%To check whether there is any scheduling conflict
check_conflict(Course1,Course2):-
    occupied(Course1,C1,T1),
    occupied(Course2,C2,T2),
    not(Course1=Course2),
    C1=C2,(T1=T2).%Same room,same time
    
%To check which room can be assigned to a given room.
course_room(Course,Room):-
    course(Course,C1,_,Needs),
    room(Room,C2,Equipments),
    C1 =< C2,%To check whether the capacity of a class is enough for course capacity 
    subset(Needs,Equipments).


%To check whether a student can be enrolled to a given room
student_room(Student,Room):-    
    student(Student,_,Needs),
    room(Room,_,Equipments),
    in(Needs,Equipments).%Handicapped or not


%To check whether an element is in array
in(E, [E|Rest]).
in(E, [I|Rest]):-
	in(E, Rest).

%To check whether a list is a subset of a list 
subset([], B).
subset([E|Rest], B):-		
	element(E, B),
	subset(Rest, B).
%To check whether an element is in array
element(E, S):-
	in(E, S).