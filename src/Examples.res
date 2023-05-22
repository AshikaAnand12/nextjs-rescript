type props = {
  msg: string,
  href: string,
}

let default = (props: props) =>
  <div>
    {React.string(props.msg)}
    <a href=props.href target="_blank"> {React.string("`src/Examples.res`")} </a>
  </div>

let getServerSideProps = _ctx => {
  let props = {
    msg: "",
    href: "localhost:3000",
  }
  Js.Promise.resolve({"props": props})
}
