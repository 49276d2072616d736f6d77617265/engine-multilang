package Core is

   type Engine_State is private;

   function Initialize return Engine_State;


   procedure Step (S : in out Engine_State);


   function Value (S : Engine_State) return Integer;

private

   type Engine_State is record
      Counter : Integer := 0;
   end record;
end Core;
