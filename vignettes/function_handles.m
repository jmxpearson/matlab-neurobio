% function handles

% you can assign a function to a variable in matlab
% with the @ sign 
% @<function name> creates what is called a "function handle"
my_new_fun = @sum;
my_other_fun = my_new_fun;

% you can then call the function with these new names
my_new_fun(1:10)
my_other_fun(1:10)

% some functions take functions as inputs
% these are very important matlab functions like:
% cellfun, arrayfun, bsxfun
% these are what are often called "higher-order" functions

% e.g. apply a function to the first, second, third, etc.
% elements of some arrays
arrayfun(@minus, 1:10,11:20)
cellfun(@strlength, {'dog', 'cat', 'penguin'})

% normally, we define functions with the `function` keyword,
% but matlab restricts where and when we can define functions in a file
% for small functions, it provides an alternative syntax
doubler = @(x) (2*x)

doubler(2.5)
doubler(pi)

% the pattern is @ (arguments) (value expression)

% another example
linear_xfm = @(A, b, x) (A * x + b)
v1 = rand(5, 4)
v2 = rand(4, 8)
v3 = rand(5, 1)
linear_xfm(v1, v3, v2)

% very fancy: functions that return functions
apply_to_max = @(fun)(@(data) fun(max(data)))

% applicator takes a function as input and returns a function that calls
% that function on the max of an input
my_fun = apply_to_max(@(x)(5*x + 1))
my_fun(1:10)