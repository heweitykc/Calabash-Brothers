package com.game.transactions.handler
{
    import com.cfg.obj.*;
    import com.game.transactions.control.*;
    import com.game.transactions.message.*;
    import com.model.vo.*;
    import com.util.*;
    import net.*;

    public class ResTransactionsIntoItemHandler extends Handler
    {

        public function ResTransactionsIntoItemHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = ResTransactionsIntoItemMessage(this.message);
            var _loc_3:* = ItemCfgObj.getInstance().getCfgBy(_loc_1.iteminfo.itemModelId);
            if (!PropUtil.isEquip(_loc_3.q_type))
            {
                _loc_2 = new PropInfo();
                _loc_2.conv(_loc_1.iteminfo);
            }
            else
            {
                _loc_2 = new EquipmentInfo();
                _loc_2.conv(_loc_1.iteminfo);
            }
            TransactionControl.getInstance().insertItemRes(_loc_1.itemposition, _loc_2, _loc_1.playerid);
            return;
        }// end function

    }
}
