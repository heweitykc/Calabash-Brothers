package com.game.autopk.mediator
{
    import com.game.autopk.controller.*;
    import com.game.autopk.model.*;
    import com.game.autopk.view.*;
    import flash.events.*;

    public class AutoFightSellMediator extends Object
    {
        private var panel:AutoFightSellSetPanel;

        public function AutoFightSellMediator(param1:AutoFightSellSetPanel)
        {
            this.panel = param1;
            param1.btn_submit.addEventListener(MouseEvent.CLICK, this.onSubmitHandle);
            param1.btn_cancel.addEventListener(MouseEvent.CLICK, this.onCancelHandle);
            return;
        }// end function

        private function onSubmitHandle(event:MouseEvent) : void
        {
            AutoFightController.getInstance().fightPanel.rd_sell2.selected = true;
            this.panel.getTableData();
            AutoFightModel.save();
            this.panel.close();
            return;
        }// end function

        private function onCancelHandle(event:MouseEvent) : void
        {
            this.panel.setTableData();
            return;
        }// end function

    }
}
