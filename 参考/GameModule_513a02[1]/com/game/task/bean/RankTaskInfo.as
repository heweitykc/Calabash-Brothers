package com.game.task.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class RankTaskInfo extends Bean
    {
        private var _modelId:int;
        private var _permiseGoods:Vector.<RankTaskAttribute>;

        public function RankTaskInfo()
        {
            this._permiseGoods = new Vector.<RankTaskAttribute>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._modelId);
            writeShort(this._permiseGoods.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._permiseGoods.length)
            {
                
                writeBean(this._permiseGoods[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._modelId = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._permiseGoods[_loc_2] = readBean(RankTaskAttribute) as RankTaskAttribute;
                _loc_2++;
            }
            return true;
        }// end function

        public function get modelId() : int
        {
            return this._modelId;
        }// end function

        public function set modelId(param1:int) : void
        {
            this._modelId = param1;
            return;
        }// end function

        public function get permiseGoods() : Vector.<RankTaskAttribute>
        {
            return this._permiseGoods;
        }// end function

        public function set permiseGoods(param1:Vector.<RankTaskAttribute>) : void
        {
            this._permiseGoods = param1;
            return;
        }// end function

    }
}
