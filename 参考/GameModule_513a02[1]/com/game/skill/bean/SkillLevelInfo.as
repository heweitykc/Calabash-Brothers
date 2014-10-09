package com.game.skill.bean
{
    import net.*;

    public class SkillLevelInfo extends Bean
    {
        private var _key:int;
        private var _level:int;

        public function SkillLevelInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._key);
            writeInt(this._level);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._key = readInt();
            this._level = readInt();
            return true;
        }// end function

        public function get key() : int
        {
            return this._key;
        }// end function

        public function set key(param1:int) : void
        {
            this._key = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

    }
}
