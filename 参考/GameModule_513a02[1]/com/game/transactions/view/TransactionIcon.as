package com.game.transactions.view
{
    import com.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.cue.*;
    import com.game.transactions.control.*;
    import flash.display.*;
    import flash.events.*;

    public class TransactionIcon extends ServerHitIcon
    {
        private var back:MovieClip;

        public function TransactionIcon(param1:String = "transactiontips")
        {
            super(param1);
            this.type = param1;
            return;
        }// end function

        override public function set visible(param1:Boolean) : void
        {
            super.visible = param1;
            return;
        }// end function

        override protected function mouseClickHandler(event:MouseEvent) : void
        {
            Global.popManager.removeServerToCue(this);
            TransactionControl.getInstance().openConfirm();
            return;
        }// end function

        override public function set tipsStr(param1:String) : void
        {
            _tipsStr = param1;
            StringTip.dispose(this);
            if (_tipsStr && _tipsStr != "")
            {
                StringTip.create(this, tipsStr);
            }
            return;
        }// end function

        override protected function getComp() : void
        {
            super.getComp();
            this.back = _content.getChildByName("back") as MovieClip;
            this.back.gotoAndStop(1);
            return;
        }// end function

        override public function set count(param1:int) : void
        {
            _count = param1;
            return;
        }// end function

    }
}
