package com.game.map.view.viewItem
{
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.sound.control.*;
    import com.staticdata.*;
    import flash.events.*;
    import flash.text.*;

    public class SoundTabelView extends Component
    {
        private var _relativeBtn:BaseButton;
        private var _relativeTxt:TextField;
        private var _clossallRad:BaseButton;
        private var _clossallRadTxt:TextField;
        private var _openallRad:BaseButton;
        private var _openallTxt:TextField;
        private var _closesomeRad:BaseButton;

        public function SoundTabelView()
        {
            initComponentUI("minmap_soundtable");
            this.move(20, 20);
            this.initUI();
            this.addListener();
            this.setSeleted(1);
            this.mouseChildren = true;
            return;
        }// end function

        private function initUI() : void
        {
            this._clossallRad = new BaseButton("sel_box_btn3", true);
            this._clossallRad.move(24, 73);
            this._relativeTxt = new TextField();
            this._clossallRad.setText(LanguageCfgObj.getInstance().getByIndex("10957"));
            this.addChild(this._clossallRad);
            this._openallRad = new BaseButton("sel_box_btn3", true);
            this._openallRad.move(24, 23);
            this._openallRad.setText(LanguageCfgObj.getInstance().getByIndex("10958"));
            this.addChild(this._openallRad);
            this._closesomeRad = new BaseButton("sel_box_btn3", true);
            this._closesomeRad.move(24, 48);
            this._closesomeRad.setText(LanguageCfgObj.getInstance().getByIndex("10959"));
            this.addChild(this._closesomeRad);
            return;
        }// end function

        private function __out(event:MouseEvent) : void
        {
            if (this.parent)
            {
                this.parent.removeChild(this);
            }
            return;
        }// end function

        private function addListener() : void
        {
            addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            addEvtListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            addEvtListener(Event.REMOVED_FROM_STAGE, this.onRemovedToStage);
            return;
        }// end function

        public function setRelativeBtn(param1:BaseButton) : void
        {
            this._relativeBtn = param1;
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            event.stopImmediatePropagation();
            switch(event.target)
            {
                case this._clossallRad:
                {
                    this.setSeleted(3);
                    SoundControl.getInstance().setting(SoundType.PLAYNO);
                    this._relativeBtn.selected = true;
                    break;
                }
                case this._openallRad:
                {
                    this.setSeleted(1);
                    SoundControl.getInstance().setting(SoundType.PLAYALL);
                    this._relativeBtn.selected = false;
                    break;
                }
                case this._closesomeRad:
                {
                    this.setSeleted(2);
                    SoundControl.getInstance().setting(SoundType.PLAYKEY);
                    this._relativeBtn.selected = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function setSeleted(param1:int) : void
        {
            switch(param1)
            {
                case 1:
                {
                    this._openallRad.selected = true;
                    this._closesomeRad.selected = false;
                    this._clossallRad.selected = false;
                    break;
                }
                case 2:
                {
                    this._openallRad.selected = false;
                    this._closesomeRad.selected = true;
                    this._clossallRad.selected = false;
                    break;
                }
                case 3:
                {
                    this._openallRad.selected = false;
                    this._closesomeRad.selected = false;
                    this._clossallRad.selected = true;
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            return;
        }// end function

        private function onRemovedToStage(event:Event) : void
        {
            return;
        }// end function

    }
}
