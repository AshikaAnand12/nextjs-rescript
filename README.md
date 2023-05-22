# nextjs-rescript

## Steps to Execute
1. npm indtall
2. npm run res:clean
3. npm run res:start

### Bug

```
src/Index.res:35:35

  33 ┆     | _ => Js.log("Some error")
  34 ┆     }
  35 ┆     Promise.reject(Js.Exn.Error(e))
  36 ┆   })
  37 ┆ })

  This has type: exn
  Somewhere wanted: Js.Exn.t (defined as Js_exn.t)

rescript: [23/23] src/App.cmj
FAILED: cannot make progress due to previous errors.
>>>> Finish compiling(exit: 1)
```
