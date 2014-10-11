package com.game.horseweapon.bean
{
    import net.*;

    public class HorseWeaponSkillInfo extends Bean
    {
        private var _skill:int;
        private var _level:int;

        public function HorseWeaponSkillInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._skill);
            writeInt(this._level);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._skill = readInt();
            this._level = readInt();
            return true;
        }// end function

        public function get skill() : int
        {
            return this._skill;
        }// end function

        public function set skill(param1:int) : void
        {
            this._skill = param1;
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
