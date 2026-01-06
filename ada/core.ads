package Core is

   -- Explicit engine state.
   -- Limited to prevent copying.
   type Engine_State is limited private;

   -- Initialize a valid engine state.
   procedure Initialize (S : out Engine_State);

   -- Advance the engine state deterministically.
   procedure Step (S : in out Engine_State)
     with Pre => Value (S) < 2;

   -- Read-only query of the engine state.
   function Value (S : Engine_State) return Integer;

private

   type Engine_State is record
      Counter : Integer := 0;
   end record;

end Core;
