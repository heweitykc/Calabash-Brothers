package com.game.guide
{

    public interface IGuide
    {

        public function IGuide();

        function registerGuide() : void;

        function guideAction(param1:String) : void;

        function guidePause(param1:String) : void;

        function guideEnd(param1:String) : void;

        function isGuideReady() : Boolean;

    }
}
