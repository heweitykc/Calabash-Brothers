package com.model.vo
{
    import com.cfg.obj.*;
    import com.game.chat.bean.*;
    import com.util.*;

    public class ChatGoodInfo extends Object
    {
        private var _queryType:int;
        private var _index:int;
        private var _propInfo:PropInfo;

        public function ChatGoodInfo(param1:GoodsInfoRes = null)
        {
            var _loc_2:* = null;
            if (param1)
            {
                this._queryType = param1.queryType;
                this._index = param1.index;
                _loc_2 = ItemCfgObj.getInstance().getCfgBy(param1.ItemInfo.itemModelId);
                if (PropUtil.isEquip(_loc_2.q_type))
                {
                    this._propInfo = new EquipmentInfo();
                    this._propInfo.conv(param1.ItemInfo);
                }
                else
                {
                    this._propInfo = new PropInfo();
                    this._propInfo.conv(param1.ItemInfo);
                }
            }
            return;
        }// end function

        public function get propInfo() : PropInfo
        {
            return this._propInfo;
        }// end function

        public function set propInfo(param1:PropInfo) : void
        {
            this._propInfo = param1;
            return;
        }// end function

        public function get queryType() : int
        {
            return this._queryType;
        }// end function

        public function set queryType(param1:int) : void
        {
            this._queryType = param1;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        public function get name() : String
        {
            if (this._propInfo is PropInfo)
            {
            }
            else if (this._propInfo is EquipmentInfo)
            {
            }
            return "";
        }// end function

    }
}
