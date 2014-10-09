package com.game.task.message
{
    import __AS3__.vec.*;
    import com.game.task.bean.*;
    import net.*;

    public class ResTargetMonsterMessage extends Message
    {
        private var _monsterInfoList:Vector.<TargetMonsterInfo>;

        public function ResTargetMonsterMessage()
        {
            this._monsterInfoList = new Vector.<TargetMonsterInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._monsterInfoList.length);
            _loc_1 = 0;
            while (_loc_1 < this._monsterInfoList.length)
            {
                
                writeBean(this._monsterInfoList[_loc_1]);
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
                
                this._monsterInfoList[_loc_1] = readBean(TargetMonsterInfo) as TargetMonsterInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 120113;
        }// end function

        public function get monsterInfoList() : Vector.<TargetMonsterInfo>
        {
            return this._monsterInfoList;
        }// end function

        public function set monsterInfoList(param1:Vector.<TargetMonsterInfo>) : void
        {
            this._monsterInfoList = param1;
            return;
        }// end function

    }
}
