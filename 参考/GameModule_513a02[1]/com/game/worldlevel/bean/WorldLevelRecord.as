package com.game.worldlevel.bean
{
    import net.*;

    public class WorldLevelRecord extends Bean
    {
        public var ranking:int;
        public var name:String;
        public var level:int;

        public function WorldLevelRecord()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this.ranking);
            writeString(this.name);
            writeInt(this.level);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.ranking = readInt();
            this.name = readString();
            this.level = readInt();
            return true;
        }// end function

    }
}
