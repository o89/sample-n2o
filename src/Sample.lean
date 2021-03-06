import Init.System.IO
import N2O.Default

def echoProto : Proto :=
{ ev := Option String,
  nothing := Result.ok,
  proto := λ p => match p with
    | Msg.text s => some s
    | _ => none }

def echo : echoProto.ev → Result
| none => Result.ok
| some s => Result.reply (Msg.text s)

def router (cx : Cx echoProto) : Cx echoProto :=
⟨cx.req, echo⟩

def handler : Handler := mkHandler echoProto [ router ]
def main := startServer handler ("localhost", 9000)

