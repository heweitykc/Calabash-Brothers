package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResSuitEffectMessage extends Message
    {
        public var playerId:long;
        public var suitEffectCount:int;
        public var suitEffectIds:Array;

        public function ResSuitEffectMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 513002;
        }// end function

        override protected function reading() : Boolean
        {
            this.playerId = readLong();
            this.suitEffectCount = readShort();
            this.suitEffectIds = [];
            var _loc_1:* = 0;
            while (_loc_1 < this.suitEffectCount)
            {
                
                this.suitEffectIds[_loc_1] = readInt();
                _loc_1++;
            }
            return true;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this.playerId);
            writeShort(this.suitEffectCount);
            var _loc_1:* = 0;
            while (_loc_1 < this.suitEffectCount)
            {
                
                writeInt(this.suitEffectIds[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

    }
}
