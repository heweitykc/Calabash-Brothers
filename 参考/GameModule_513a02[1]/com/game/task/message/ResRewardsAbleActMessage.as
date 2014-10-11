package com.game.task.message
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import net.*;

    public class ResRewardsAbleActMessage extends Message
    {
        private var _ableAct:Vector.<ItemInfo>;

        public function ResRewardsAbleActMessage()
        {
            this._ableAct = new Vector.<ItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._ableAct.length);
            _loc_1 = 0;
            while (_loc_1 < this._ableAct.length)
            {
                
                writeBean(this._ableAct[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._ableAct[_loc_1] = readBean(ItemInfo) as ItemInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 120103;
        }// end function

        public function get ableAct() : Vector.<ItemInfo>
        {
            return this._ableAct;
        }// end function

        public function set ableAct(param1:Vector.<ItemInfo>) : void
        {
            this._ableAct = param1;
            return;
        }// end function

    }
}
