package Core is

   Max_Value : constant Integer := 2;

   -- Explicit engine state (opaque)
   type Engine_State is limited private;

   procedure Initialize (S : out Engine_State)
     with Post => Value (S) = 0;

   procedure Step (S : in out Engine_State)
     with Pre => Value (S) < Max_Value;

   function Value (S : Engine_State) return Integer;

   -- Expose size for foreign allocators (Zig, C, etc.)
   function State_Size return Natural;

private

   type Engine_State is record
      Counter : Integer := 0;
   end record
     with Invariant =>
       Counter in 0 .. Max_Value;

end Core;
