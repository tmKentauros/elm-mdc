module Demo.Dialog exposing (Model, Msg(..), defaultModel, update, view)

import Demo.Page as Page exposing (Page)
import Html exposing (Html, text)
import Html.Attributes as Html
import Material
import Material.Button as Button
import Material.Checkbox as Checkbox
import Material.Dialog as Dialog
import Material.FormField as FormField
import Material.List as Lists
import Material.Options as Options exposing (cs, css, styled, when)
import Material.RadioButton as RadioButton


type alias Model m =
    { mdc : Material.Model m
    , openDialog : String
    , dialogOpen : Bool
    , ringtone : String
    }


defaultModel : Model m
defaultModel =
    { mdc = Material.defaultModel
    , openDialog = ""
    , dialogOpen = False
    , ringtone = "dialog-ringtone-0"
    }


type Msg m
    = Mdc (Material.Msg m)
    | ButtonClicked String
    | DialogClosed
    | RingtoneChanged String


update : (Msg m -> m) -> Msg m -> Model m -> ( Model m, Cmd m )
update lift msg model =
    case msg of
        Mdc msg_ ->
            Material.update (lift << Mdc) msg_ model

        DialogClosed ->
            ( { model | dialogOpen = False }, Cmd.none )

        ButtonClicked index ->
            ( { model | openDialog = index, dialogOpen = True }, Cmd.none )

        RingtoneChanged index ->
            ( { model | ringtone = index }, Cmd.none )


heroDialog : (Msg m -> m) -> Material.Index -> Model m -> Html m
heroDialog lift index model =
    Dialog.view (lift << Mdc)
        index
        model.mdc
        [ cs "hero-demo"
        , cs "mdc-dialog--open"
        ]
        [ Dialog.surface []
            [ Dialog.header []
                [ styled Html.h2
                    [ Dialog.title ]
                    [ text "Get this party started?" ]
                ]
            , Dialog.body []
                [ text "Turn up the jams and have a good time." ]
            , Dialog.footer []
                [ Button.view (lift << Mdc)
                    (index ++ "__button-cancel")
                    model.mdc
                    [ Button.ripple
                    , Dialog.cancel
                    ]
                    [ text "Decline" ]
                , Button.view (lift << Mdc)
                    (index ++ "__button-accept")
                    model.mdc
                    [ Button.ripple
                    , Dialog.accept
                    ]
                    [ text "Accept" ]
                ]
            ]
        ]


alertDialog : (Msg m -> m) -> Material.Index -> Model m -> Html m
alertDialog lift index model =
    let
        isOpen =
            (model.openDialog == index) && model.dialogOpen
    in
    Dialog.view (lift << Mdc)
        index
        model.mdc
        [ Dialog.onClose (lift DialogClosed)
        , when isOpen Dialog.open
        ]
        [ Dialog.surface []
            [ Dialog.body []
                [ Html.p [] [ text "Discard draft?" ] ]
            , Dialog.footer []
                [ Button.view (lift << Mdc)
                    (index ++ "__button-cancel")
                    model.mdc
                    [ Button.ripple
                    , Dialog.cancel
                    , Button.onClick (lift DialogClosed)
                    ]
                    [ text "Cancel" ]
                , Button.view (lift << Mdc)
                    (index ++ "__button-accept")
                    model.mdc
                    [ Button.ripple
                    , Dialog.accept
                    , Button.onClick (lift DialogClosed)
                    ]
                    [ text "Discard" ]
                ]
            ]
        , Dialog.backdrop [] []
        ]


simpleDialog : (Msg m -> m) -> Material.Index -> Model m -> Html m
simpleDialog lift index model =
    let
        isOpen =
            (model.openDialog == index) && model.dialogOpen
    in
    Dialog.view (lift << Mdc)
        index
        model.mdc
        [ Dialog.onClose (lift DialogClosed)
        , when isOpen Dialog.open
        ]
        [ Dialog.surface []
            [ Dialog.header []
                [ styled Html.h2
                    [ Dialog.title ]
                    [ text "Select an account" ]
                ]
            , Dialog.body []
                [ Lists.ul
                    [ Lists.avatarList ]
                    [ Lists.li
                        [ Options.onClick (lift DialogClosed) ]
                        [ Lists.graphicIcon [] "person"
                        , text "user1@example.com"
                        ]
                    , Lists.li
                        [ Options.onClick (lift DialogClosed) ]
                        [ Lists.graphicIcon [] "person"
                        , text "user2@example.com"
                        ]
                    , Lists.li
                        [ Options.onClick (lift DialogClosed) ]
                        [ Lists.graphicIcon [] "add"
                        , text "Add account"
                        ]
                    ]
                ]
            ]
        , Dialog.backdrop [] []
        ]


confirmationDialog : (Msg m -> m) -> Material.Index -> Model m -> Html m
confirmationDialog lift index model =
    let
        isOpen =
            (model.openDialog == index) && model.dialogOpen

        radiobutton ringtone =
            RadioButton.view (lift << Mdc)
                ringtone
                model.mdc
                [ when (model.ringtone == ringtone) RadioButton.selected
                ]
                []
    in
    Dialog.view (lift << Mdc)
        index
        model.mdc
        [ Dialog.onClose (lift DialogClosed)
        , when isOpen Dialog.open
        ]
        [ Dialog.surface []
            [ Dialog.header []
                [ styled Html.h2
                    [ Dialog.title ]
                    [ text "Phone ringtone" ]
                ]
            , Dialog.body []
                [ Lists.ul []
                    [ Lists.li
                        [ Options.onClick (lift (RingtoneChanged "dialog-ringtone-0")) ]
                        [ Lists.graphic [] [ radiobutton "dialog-ringtone-0" ]
                        , text "Never Gonna Give You Up"
                        ]
                    , Lists.li
                        [ Options.onClick (lift (RingtoneChanged "dialog-ringtone-1")) ]
                        [ Lists.graphic [] [ radiobutton "dialog-ringtone-1" ]
                        , text "Hot Cross Buns"
                        ]
                    , Lists.li
                        [ Options.onClick (lift (RingtoneChanged "dialog-ringtone-2")) ]
                        [ Lists.graphic [] [ radiobutton "dialog-ringtone-2" ]
                        , text "None"
                        ]
                    ]
                ]
            , Dialog.footer []
                [ Button.view (lift << Mdc)
                    (index ++ "__button-cancel")
                    model.mdc
                    [ Button.ripple
                    , Dialog.cancel
                    , Button.onClick (lift DialogClosed)
                    ]
                    [ text "Cancel" ]
                , Button.view (lift << Mdc)
                    (index ++ "__button-accept")
                    model.mdc
                    [ Button.ripple
                    , Dialog.accept
                    , Button.onClick (lift DialogClosed)
                    ]
                    [ text "Ok" ]
                ]
            ]
        , Dialog.backdrop [] []
        ]


scrollableDialog : (Msg m -> m) -> Material.Index -> Model m -> Html m
scrollableDialog lift index model =
    let
        isOpen =
            (model.openDialog == index) && model.dialogOpen
    in
    Dialog.view (lift << Mdc)
        index
        model.mdc
        [ Dialog.onClose (lift DialogClosed)
        , when isOpen Dialog.open
        ]
        [ Dialog.surface []
            [ Dialog.header []
                [ styled Html.h2
                    [ Dialog.title ]
                    [ text "The Wonderful Wizard of Oz" ]
                ]
            , Dialog.body
                [ Dialog.scrollable
                ]
                [ Html.p []
                    [ Html.a
                        [ Html.href "https://www.gutenberg.org/ebooks/55"
                        , Html.target "_blank"
                        ]
                        [ text "Read the full book" ]
                    ]
                , Html.p []
                    [ text
                        """
                        Dorothy lived in the midst of the great Kansas
                        prairies, with Uncle Henry, who was a farmer, and Aunt
                        Em, who was the farmer's wife. Their house was small,
                        for the lumber to build it had to be carried by wagon
                        many miles. There were four walls, a floor and a roof,
                        which made one room; and this room contained a rusty
                        looking cookstove, a cupboard for the dishes, a table,
                        three or four chairs, and the beds. Uncle Henry and
                        Aunt Em had a big bed in one corner, and Dorothy a
                        little bed in another corner. There was no garret at
                        all, and no cellar--except a small hole dug in the
                        ground, called a cyclone cellar, where the family could
                        go in case one of those great whirlwinds arose, mighty
                        enough to crush any building in its path. It was
                        reached by a trap door in the middle of the floor, from
                        which a ladder led down into the small, dark hole.
                        """
                    ]
                , Html.p []
                    [ text
                        """
                        When Dorothy stood in the doorway and looked around,
                        she could see nothing but the great gray prairie on
                        every side. Not a tree nor a house broke the broad
                        sweep of flat country that reached to the edge of the
                        sky in all directions. The sun had baked the plowed
                        land into a gray mass, with little cracks running
                        through it. Even the grass was not green, for the sun
                        had burned the tops of the long blades until they were
                        the same gray color to be seen everywhere. Once the
                        house had been painted, but the sun blistered the paint
                        and the rains washed it away, and now the house was as
                        dull and gray as everything else.
                        """
                    ]
                , Html.p []
                    [ text
                        """
                        When Aunt Em came there to live she was a young, pretty
                        wife. The sun and wind had changed her, too. They had
                        taken the sparkle from her eyes and left them a sober
                        gray; they had taken the red from her cheeks and lips,
                        and they were gray also. She was thin and gaunt, and
                        never smiled now. When Dorothy, who was an orphan,
                        first came to her, Aunt Em had been so startled by the
                        child's laughter that she would scream and press her
                        hand upon her heart whenever Dorothy's merry voice
                        reached her ears; and she still looked at the little
                        girl with wonder that she could find anything to laugh
                        at.
                        """
                    ]
                , Html.p []
                    [ text
                        """
                        Uncle Henry never laughed. He worked hard from morning
                        till night and did not know what joy was. He was gray
                        also, from his long beard to his rough boots, and he
                        looked stern and solemn, and rarely spoke.
                        """
                    ]
                , Html.p []
                    [ text
                        """
                        It was Toto that made Dorothy laugh, and saved her from
                        growing as gray as her other surroundings. Toto was not
                        gray; he was a little black dog, with long silky hair
                        and small black eyes that twinkled merrily on either
                        side of his funny, wee nose. Toto played all day long,
                        and Dorothy played with him, and loved him dearly.
                        """
                    ]
                , Html.p []
                    [ text
                        """
                        Today, however, they were not playing. Uncle Henry sat
                        upon the doorstep and looked anxiously at the sky,
                        which was even grayer than usual. Dorothy stood in the
                        door with Toto in her arms, and looked at the sky too.
                        Aunt Em was washing the dishes.
                        """
                    ]
                , Html.p []
                    [ text
                        """
                        From the far north they heard a low wail of the wind,
                        and Uncle Henry and Dorothy could see where the long
                        grass bowed in waves before the coming storm. There now
                        came a sharp whistling in the air from the south, and
                        as they turned their eyes that way they saw ripples in
                        the grass coming from that direction also.
                        """
                    ]
                ]
            , Dialog.footer []
                [ Button.view (lift << Mdc)
                    (index ++ "__button-cancel")
                    model.mdc
                    [ Button.ripple
                    , Dialog.cancel
                    , Button.onClick (lift DialogClosed)
                    ]
                    [ text "Decline" ]
                , Button.view (lift << Mdc)
                    (index ++ "__button-accept")
                    model.mdc
                    [ Button.ripple
                    , Dialog.accept
                    , Button.onClick (lift DialogClosed)
                    ]
                    [ text "Accept" ]
                ]
            ]
        , Dialog.backdrop [] []
        ]


view : (Msg m -> m) -> Page m -> Model m -> Html m
view lift page model =
    page.demoPage
        { title = "Dialog"
        , prelude =
            [ """
              Dialogs inform users about a specific task and may contain
              critical information, require decisions, or involve multiple
              tasks.
              """
            ]
        , resources =
            { materialGuidelines = ""
            , documentation = ""
            , sourceCode = ""
            }
        , hero =
            [ heroDialog lift "dialog-hero-dialog" model
            ]
        , content =
            [ Button.view (lift << Mdc)
                "dialog-alert-dialog-button"
                model.mdc
                [ Button.ripple
                , Button.onClick (lift (ButtonClicked "dialog-alert-dialog"))
                ]
                [ text "Alert"
                ]
            , Button.view (lift << Mdc)
                "dialog-simple-dialog-button"
                model.mdc
                [ Button.ripple
                , Button.onClick (lift (ButtonClicked "dialog-simple-dialog"))
                ]
                [ text "Simple"
                ]
            , Button.view (lift << Mdc)
                "dialog-confirmation-dialog-button"
                model.mdc
                [ Button.ripple
                , Button.onClick (lift (ButtonClicked "dialog-confirmation-dialog"))
                ]
                [ text "Confirmation"
                ]
            , Button.view (lift << Mdc)
                "dialog-scrollable-dialog-button"
                model.mdc
                [ Button.ripple
                , Button.onClick (lift (ButtonClicked "dialog-scrollable-dialog"))
                ]
                [ text "Scrollable"
                ]
            , alertDialog lift "dialog-alert-dialog" model
            , simpleDialog lift "dialog-simple-dialog" model
            , confirmationDialog lift "dialog-confirmation-dialog" model
            , scrollableDialog lift "dialog-scrollable-dialog" model
            , Html.node "style"
                [ Html.type_ "text/css" ]
                [ text style ]
            ]
        }


style : String
style =
    """
    .hero-demo {
      position: relative;
      z-index: 0;
    }
    """
