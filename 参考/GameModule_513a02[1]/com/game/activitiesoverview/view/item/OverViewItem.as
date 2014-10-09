package com.game.activitiesoverview.view.item
{
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.game.activitiesoverview.control.*;
    import com.model.vo.*;
    import com.view.ui.list.*;
    import flash.events.*;
    import flash.text.*;

    public class OverViewItem extends ListItem implements IItem
    {
        private var _info:LivenessInfo;
        private var _label:TextField;
        private var _numTxt:TextField;
        private var _completeTxt:TextField;
        private var _goToBtn:BaseButton;

        public function OverViewItem(param1:String = "signup.upfinished")
        {
            super(param1, "mc");
            this.initUI();
            this.addlistener();
            return;
        }// end function

        public function initUI() : void
        {
            return;
        }// end function

        public function update(param1:int) : void
        {
            this._info.times = param1;
            this.receive();
            return;
        }// end function

        public function addlistener() : void
        {
            this._goToBtn.addEvtListener(MouseEvent.CLICK, this.__click);
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._goToBtn:
                {
                    ActivitiesOverviewControl.getInstance().doAssignment(this._info.type_id);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        public function check() : void
        {
            return;
        }// end function

        override protected function receive() : void
        {
            this._info = obj;
            this._label.text = this._info.label;
            this._numTxt.text = (this._info.times < this._info.q_count ? (this._info.times) : (this._info.q_count)) + "/" + this._info.q_count;
            StringTip.create(this, this._info.tips);
            if (this._info.times >= this._info.q_count)
            {
                this._goToBtn.visible = false;
                this._completeTxt.visible = true;
            }
            else if (this._info.canGo)
            {
                this._goToBtn.visible = true;
                this._completeTxt.visible = false;
            }
            else
            {
                this._goToBtn.visible = false;
                this._completeTxt.visible = false;
            }
            return;
        }// end function

        override protected function getComp() : void
        {
            this._label = _content.getChildByName("txt_label") as TextField;
            this._numTxt = _content.getChildByName("txt_count") as TextField;
            this._completeTxt = _content.getChildByName("completeTxt") as TextField;
            this._completeTxt.mouseEnabled = false;
            this._completeTxt.multiline = false;
            this._goToBtn = new BaseButton(_content.getChildByName("gotoBtn"));
            return;
        }// end function

        override public function finalize() : void
        {
            this._goToBtn.removeEvtListener(MouseEvent.CLICK, this.__click);
            super.finalize();
            return;
        }// end function

    }
}
