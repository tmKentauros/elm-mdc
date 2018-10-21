module Demo.Textfields exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Dict exposing (Dict)
import Html exposing (Html, text)
import Html.Attributes as Html
import Html.Events as Html
import Material
import Material.Options as Options exposing (cs, css, styled, when)
import Material.Textfield as TextField
import Material.Textfield.HelperText as TextField
import Material.Typography as Typography


type alias Model m =
    { mdc : Material.Model m
    }


defaultModel : Model m
defaultModel =
    { mdc = Material.defaultModel
    }


type Msg m
    = Mdc (Material.Msg m)


update : (Msg m -> m) -> Msg m -> Model m -> ( Model m, Cmd m )
update lift msg model =
    case msg of
        Mdc msg_ ->
            Material.update (lift << Mdc) msg_ model


view : (Msg m -> m) -> Page m -> Model m -> Html m
view lift page model =
    page.demoPage
        { title = "Text Field"
        , prelude =
            [ """
          Text fields allow users to input, edit, and select text. Text fields
          typically reside in forms but can appear in other places, like dialog
          boxes and search.
          """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ heroTextField lift model
            ]
        , content =
            [ styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Filled" ]
            , filledTextFields lift model
            , styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Filled with Leading Icon" ]
            , filledTextFieldsWithLeadingIcon lift model
            , styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Filled with Trailing Icon" ]
            , filledTextFieldsWithTrailingIcon lift model
            , styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Outlined" ]
            , outlinedTextFields lift model
            , styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Outlined with Leading Icon" ]
            , outlinedTextFieldsWithLeadingIcon lift model
            , styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Outlined with Trailing Icon" ]
            , outlinedTextFieldsWithTrailingIcon lift model
            , styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Textarea" ]
            , textareas lift model
            , styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Full Width" ]
            , fullwidthTextFields lift model
            , styled Html.h3
                [ Typography.subtitle1 ]
                [ text "Full Width Textarea" ]
            , fullwidthTextareas lift model
            , Html.node "style"
                [ Html.type_ "text/css" ]
                [ text style ]
            ]
        }


style : String
style =
    """
    .text-field-row {
      display: -ms-flexbox;
      display: flex;
      -ms-flex-align: start;
      align-items: flex-start;
      -ms-flex-pack: justify;
      justify-content: space-between;
      -ms-flex-wrap: wrap;
      flex-wrap: wrap;
    }

    .text-field-container {
      min-width: 200px;
    }

    .text-field-row-fullwidth {
      display: block;
    }

    .text-field-row-fullwidth .text-field-container {
      margin-bottom: 8px;
    }
    """


heroTextField : (Msg m -> m) -> Model m -> Html m
heroTextField lift model =
    Html.div
        [ Html.class "text-field-container"
        ]
        [ TextField.view (lift << Mdc)
            "text-fields-hero-text-field"
            model.mdc
            [ TextField.label "Standard" ]
            []
        ]


filledTextFields : (Msg m -> m) -> Model m -> Html m
filledTextFields lift model =
    Html.div
        [ Html.class "text-field-row"
        ]
        [ Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-filled-text-field"
                model.mdc
                [ TextField.label "Standard" ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-dense-filled-text-field"
                model.mdc
                [ TextField.label "Dense"
                , TextField.dense
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-filled-text-field-with-helper-text"
                model.mdc
                [ TextField.label "Standard"
                ]
                []
            , TextField.helperText
                [ TextField.persistent ]
                [ text "Helper Text"
                ]
            ]
        ]


filledTextFieldsWithLeadingIcon : (Msg m -> m) -> Model m -> Html m
filledTextFieldsWithLeadingIcon lift model =
    Html.div
        [ Html.class "text-field-row"
        ]
        [ Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-filled-text-field-with-leading-icon"
                model.mdc
                [ TextField.label "Standard"
                , TextField.leadingIcon "event"
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-dense-filled-text-field-with-leading-icon"
                model.mdc
                [ TextField.label "Dense"
                , TextField.dense
                , TextField.leadingIcon "event"
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-filled-text-field-with-leading-icon-and-helper-text"
                model.mdc
                [ TextField.label "Standard"
                , TextField.leadingIcon "event"
                ]
                []
            , TextField.helperText
                [ TextField.persistent
                ]
                [ text "Helper Text"
                ]
            ]
        ]


filledTextFieldsWithTrailingIcon : (Msg m -> m) -> Model m -> Html m
filledTextFieldsWithTrailingIcon lift model =
    Html.div
        [ Html.class "text-field-row"
        ]
        [ Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-filled-text-field-with-trailing-icon"
                model.mdc
                [ TextField.label "Standard"
                , TextField.trailingIcon "event"
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-dense-filled-text-field-with-trailing-icon"
                model.mdc
                [ TextField.label "Dense"
                , TextField.dense
                , TextField.trailingIcon "event"
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-filled-text-field-with-trailing-icon-and-helper-text"
                model.mdc
                [ TextField.label "Standard"
                , TextField.trailingIcon "event"
                ]
                []
            , TextField.helperText
                [ TextField.persistent
                ]
                [ text "Helper Text"
                ]
            ]
        ]


outlinedTextFields : (Msg m -> m) -> Model m -> Html m
outlinedTextFields lift model =
    Html.div
        [ Html.class "text-field-row"
        ]
        [ Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-outlined-text-field"
                model.mdc
                [ TextField.label "Standard"
                , TextField.outlined
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-dense-outlined-text-field"
                model.mdc
                [ TextField.label "Dense"
                , TextField.outlined
                , TextField.dense
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-outlined-text-field-with-helper-text"
                model.mdc
                [ TextField.label "Standard"
                , TextField.outlined
                ]
                []
            , TextField.helperText
                [ TextField.persistent ]
                [ text "Helper Text"
                ]
            ]
        ]


outlinedTextFieldsWithLeadingIcon : (Msg m -> m) -> Model m -> Html m
outlinedTextFieldsWithLeadingIcon lift model =
    Html.div
        [ Html.class "text-field-row"
        ]
        [ Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-outlined-text-field-with-leading-icon"
                model.mdc
                [ TextField.label "Standard"
                , TextField.outlined
                , TextField.leadingIcon "event"
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-dense-outlined-text-field-with-leading-icon"
                model.mdc
                [ TextField.label "Dense"
                , TextField.outlined
                , TextField.dense
                , TextField.leadingIcon "event"
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-outlined-text-field-with-leading-icon-and-helper-text"
                model.mdc
                [ TextField.label "Standard"
                , TextField.outlined
                , TextField.leadingIcon "event"
                ]
                []
            , TextField.helperText
                [ TextField.persistent
                ]
                [ text "Helper Text"
                ]
            ]
        ]


outlinedTextFieldsWithTrailingIcon : (Msg m -> m) -> Model m -> Html m
outlinedTextFieldsWithTrailingIcon lift model =
    Html.div
        [ Html.class "text-field-row"
        ]
        [ Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-outlined-text-field-with-trailing-icon"
                model.mdc
                [ TextField.label "Standard"
                , TextField.outlined
                , TextField.trailingIcon "event"
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-dense-outlined-text-field-with-trailing-icon"
                model.mdc
                [ TextField.label "Dense"
                , TextField.outlined
                , TextField.dense
                , TextField.trailingIcon "event"
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-outlined-text-field-with-trailing-icon-and-helper-text"
                model.mdc
                [ TextField.label "Standard"
                , TextField.outlined
                , TextField.trailingIcon "event"
                ]
                []
            , TextField.helperText
                [ TextField.persistent
                ]
                [ text "Helper Text"
                ]
            ]
        ]


textareas : (Msg m -> m) -> Model m -> Html m
textareas lift model =
    Html.div
        [ Html.class "text-field-row"
        ]
        [ Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-textarea-text-field"
                model.mdc
                [ TextField.label "Standard"
                , TextField.textarea
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-dense-textarea-text-field"
                model.mdc
                [ TextField.label "Dense"
                , TextField.textarea
                , TextField.dense
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-textarea-text-field-with-helper-text"
                model.mdc
                [ TextField.label "Standard"
                , TextField.textarea
                ]
                []
            , TextField.helperText
                [ TextField.persistent ]
                [ text "Helper Text"
                ]
            ]
        ]


fullwidthTextFields : (Msg m -> m) -> Model m -> Html m
fullwidthTextFields lift model =
    Html.div
        [ Html.class "text-field-row text-field-row-fullwidth"
        ]
        [ Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-fullwidth-text-field"
                model.mdc
                [ TextField.placeholder "Standard"
                , TextField.fullwidth
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-dense-fullwidth-text-field"
                model.mdc
                [ TextField.placeholder "Dense"
                , TextField.fullwidth
                , TextField.dense
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-fullwidth-text-field-with-helper-text"
                model.mdc
                [ TextField.placeholder "Standard"
                , TextField.fullwidth
                ]
                []
            , TextField.helperText
                [ TextField.persistent ]
                [ text "Helper Text"
                ]
            ]
        ]


fullwidthTextareas : (Msg m -> m) -> Model m -> Html m
fullwidthTextareas lift model =
    Html.div
        [ Html.class "text-field-row text-field-row-fullwidth"
        ]
        [ Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-fullwidth-textarea-text-field"
                model.mdc
                [ TextField.label "Standard"
                , TextField.fullwidth
                , TextField.textarea
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-dense-fullwidth-textarea-text-field"
                model.mdc
                [ TextField.label "Dense"
                , TextField.fullwidth
                , TextField.textarea
                , TextField.dense
                ]
                []
            ]
        , Html.div
            [ Html.class "text-field-container"
            ]
            [ TextField.view (lift << Mdc)
                "text-fields-fullwidth-textarea-text-field-with-helper-text"
                model.mdc
                [ TextField.label "Standard"
                , TextField.fullwidth
                , TextField.textarea
                ]
                []
            , TextField.helperText
                [ TextField.persistent ]
                [ text "Helper Text"
                ]
            ]
        ]
