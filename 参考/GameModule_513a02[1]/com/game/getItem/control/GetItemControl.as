package com.game.getItem.control
{
    import com.cfg.obj.*;
    import com.game.backpack.message.*;
    import com.game.backpack.model.*;
    import com.game.map.control.*;
    import com.model.vo.*;
    import com.staticdata.*;

    public class GetItemControl extends Object
    {
        private var _boxes:Array;
        private static var _inst:GetItemControl;

        public function GetItemControl()
        {
            this._boxes = [730106];
            return;
        }// end function

        public function useItem(param1:ResUseItemSuccessMessage) : void
        {
            var _loc_2:* = ItemCfgObj.getInstance().getCfgBy(param1.itemId);
            if (_loc_2.q_type == ItemType.CHEST && _loc_2.q_swf && _loc_2.q_swf != "")
            {
                MapControl.getInstance().addyanhua(_loc_2.q_swf);
            }
            return;
        }// end function

        public function getItem(param1:ResGetItemReasonsMessage) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < param1.itemReasonsInfoList.length)
            {
                
                _loc_3 = BackpackObj.getInstance().getItemById(param1.itemReasonsInfoList[_loc_2].itemId);
                _loc_4 = _loc_3.clone() as PropInfo;
                if (_loc_3)
                {
                    _loc_4.num = param1.itemReasonsInfoList[_loc_2].itemNum;
                    MapControl.getInstance().addChest(_loc_4);
                }
                _loc_2++;
            }
            return;
        }// end function

        public static function get Instance() : GetItemControl
        {
            var _loc_1:* = new GetItemControl;
            _inst = new GetItemControl;
            return _inst || _loc_1;
        }// end function

    }
}
