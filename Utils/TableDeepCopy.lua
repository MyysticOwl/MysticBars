-- By defualt Lua makes shallow copies when one variable is assigned to another.
-- That is, its variables act like pointers, and changes to one are reflected
-- in all others pointing to the same thing. This function makes a deep copy (it
-- actually assigns the values of one table to another). It is recursive too, so
-- even tables containing tables will be handled properly.
   
