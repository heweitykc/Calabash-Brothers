package com.game.historymsg.view
{
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.historymsg.bean.*;
    import com.game.historymsg.control.*;
    import com.game.historymsg.util.*;
    import flash.events.*;
    import flash.text.*;

    public class HistorymsgListRowView extends Component
    {
        private var viewTitle:TextField;
        private var btnRemove:BaseButton;
        private var btnSee:BaseButton;
        public var msg:HistorymsgMsg;

        public function HistorymsgListRowView()
        {
            super("historymsgListRowView");
            this.viewTitle = getDisplayChildByName("viewTitle");
            this.btnRemove = HistorymsgUiUtil.createButtonWithExtraLabel(this, "btnRemove", this.onRemove);
            this.btnSee = HistorymsgUiUtil.createButtonWithExtraLabel(this, "btnSee", this.onSee);
            return;
        }// end function

        public function setData(param1:HistorymsgMsg) : void
        {
            this.msg = param1;
            this.viewTitle.text = param1.title;
            return;
        }// end function

        private function onRemove(event:MouseEvent) : void
        {
            HistorymsgControl.getInstance().removeMsg(this.msg);
            return;
        }// end function

        private function onSee(event:MouseEvent) : void
        {
            HistorymsgControl.getInstance().seeMsg(this.msg);
            return;
        }// end function

    }
}
