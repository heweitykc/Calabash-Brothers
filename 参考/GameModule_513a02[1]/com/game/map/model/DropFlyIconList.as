package com.game.map.model
{
    import com.game.map.view.*;
    import com.game.utils.*;
    import flash.utils.*;

    public class DropFlyIconList extends Object
    {
        private var list:Dictionary;
        private static var instance:DropFlyIconList;

        public function DropFlyIconList()
        {
            return;
        }// end function

        public function reset() : void
        {
            var _loc_1:* = null;
            for each (_loc_1 in this.list)
            {
                
                _loc_1.dispose();
            }
            this.list = new Dictionary();
            return;
        }// end function

        public function addDrop(param1:DropFlyIcon) : void
        {
            if (param1 && param1.info)
            {
                this.list[param1.info.dropGoodsId.toString()] = param1;
            }
            return;
        }// end function

        public function removeDrop(param1:DropFlyIcon) : void
        {
            this.list[param1.info.dropGoodsId.toString()] = null;
            delete this.list[param1.info.dropGoodsId.toString()];
            return;
        }// end function

        public function getDrop(param1:long) : DropFlyIcon
        {
            return this.list[param1.toString()];
        }// end function

        public static function getInstance() : DropFlyIconList
        {
            if (instance == null)
            {
                instance = new DropFlyIconList;
            }
            return instance;
        }// end function

    }
}
