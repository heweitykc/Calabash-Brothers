package com.game.task.message
{
    import com.game.task.bean.*;
    import net.*;

    public class ResTargetMonsterChangeMessage extends Message
    {
        private var _monsterInfo:TargetMonsterInfo;

        public function ResTargetMonsterChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._monsterInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._monsterInfo = readBean(TargetMonsterInfo) as TargetMonsterInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 120110;
        }// end function

        public function get monsterInfo() : TargetMonsterInfo
        {
            return this._monsterInfo;
        }// end function

        public function set monsterInfo(param1:TargetMonsterInfo) : void
        {
            this._monsterInfo = param1;
            return;
        }// end function

    }
}
