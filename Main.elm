module Main where

import Effects exposing (Effects,Never,none)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal exposing (Signal, Address)
import StartApp exposing (App)
import Task exposing (Task)

------------------------------------------------------------

type alias Model =
  {counter : Int}

type Action
  = Increment

------------------------------------------------------------

init : (Model, Effects Action)
init = ({counter = 0}, none)

view : Address Action -> Model -> Html
view address model =
  div [style [("text-align", "center")
             ,("font-size", "20px")]]
      [h1 []
          [text ("Incredible Demo: " ++ toString model.counter)]
      ,button [onClick address Increment]
              [text "Increment"]]

update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    Increment -> ({model | counter <- model.counter + 1}
                 ,none)

------------------------------------------------------------

app : App Model
app = StartApp.start {init = init
                     ,view = view
                     ,update = update
                     ,inputs = []}

main : Signal Html
main = app.html

port tasks : Signal (Task Never ())
port tasks = app.tasks
