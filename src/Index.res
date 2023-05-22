@module("axios")
external axiosGet: string => Js.Promise.t<'a> = "get"

open Promise

module P = {
  @react.component
  let make = (~children) => <p className="mb-2"> children </p>
}

type company = {name: string}

type user = {
  username: string,
  name: string,
  company: company,
}

@react.component
let make = () => {
  let (data, setData) = React.useState(() => Js.Nullable.null)

  React.useEffect(() => {
    axiosGet("https://jsonplaceholder.typicode.com/users")
    ->then(response => {
      response->Js.log
      setData(_ => Js.Nullable.return(response))
      Promise.resolve()
    })
    ->catch(e => {
      switch e {
      | JsError(obj) => obj->Js.Exn.message->Belt.Option.getWithDefault("No message")->Js.log
      | _ => Js.log("Some error")
      }
      Promise.reject(Js.Exn.Error(e))
    })
  })

  <div>
    <span>
      <table className="border-4 w-full divide-y divide-gray-200 dark:divide-gray-700">
        <thead>
          <tr>
            <th
              className="py-2 px-4 bg-gray-100 dark:bg-gray-800 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              {"Username"->React.string}
            </th>
            <th
              className="py-2 px-4 bg-gray-100 dark:bg-gray-800 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              {"Full Name"->React.string}
            </th>
            <th
              className="py-2 px-4 bg-gray-100 dark:bg-gray-800 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
              {"Company"->React.string}
            </th>
          </tr>
        </thead>
        <tbody>
          {switch Js.Nullable.toOption(data) {
          | Some(users) =>
            Belt.Array.mapWithIndex(users, (index, user) =>
              <tr key={string_of_int(index)}>
                <td className="py-2 px-4"> {user.username->React.string} </td>
                <td className="py-2 px-4"> {user.name->React.string} </td>
                <td className="py-2 px-4"> {user.company.name->React.string} </td>
              </tr>
            )
          | None => <tr> <td colSpan=3> {"Loading..."->React.string} </td> </tr>
          }}
        </tbody>
      </table>
    </span>
  </div>
}
