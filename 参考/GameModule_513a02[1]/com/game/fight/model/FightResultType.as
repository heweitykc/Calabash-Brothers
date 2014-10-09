package com.game.fight.model
{

    public class FightResultType extends Object
    {
        public static const SUCCESS:uint = 0;
        public static const MISS:uint = 1;
        public static const JUMP_BLINK:uint = 2;
        public static const CRITICAL:uint = 4;
        public static const BLOCK:uint = 8;
        public static const JUMP_BLINK_CRITICAL:uint = 6;
        public static const BLOCK_CRITICAL:uint = 12;
        public static const INVINCIBLE:uint = 16;
        public static const ATTACKED_IN_DEAD:uint = 32;
        public static const SEC_KILL:uint = 64;
        public static const IMMU_DEC_SPEED:int = 2;
        public static const IMMU_POISON:int = 1;
        public static const IMMU_FIX_BODY:int = 4;
        public static const IMMU_VERTIGO:int = 3;
        public static const IMMU_DAMAGE:int = 0;

        public function FightResultType()
        {
            return;
        }// end function

    }
}
