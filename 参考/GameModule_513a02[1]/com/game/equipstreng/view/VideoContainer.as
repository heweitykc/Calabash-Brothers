package com.game.equipstreng.view
{
    import com.game.equipstreng.control.*;
    import com.game.equipstreng.events.*;
    import flash.display.*;
    import flash.events.*;

    public class VideoContainer extends Sprite
    {
        private var video:NetConnectionExample;
        private var _url:String = "";
        private var _type:int;
        public static var TYPE_STRENG:int = 1;
        public static var TYPE_FIRE:int = 2;

        public function VideoContainer(param1:String, param2:int)
        {
            this._url = param1;
            this._type = param2;
            this.visible = false;
            MyDispatcher.myEvent.addEventListener(VideoEvent.VIDEO_CLOSE, this.closeVideoWin);
            return;
        }// end function

        public function openVideo() : void
        {
            if (this.video == null)
            {
                this.video = new NetConnectionExample();
                this.addChild(this.video);
            }
            this.play();
            this.visible = true;
            return;
        }// end function

        public function play() : void
        {
            if (this.video)
            {
                this.video.play(this._url, this._type);
            }
            return;
        }// end function

        public function stop() : void
        {
            if (this.video)
            {
                this.video.stop();
            }
            return;
        }// end function

        private function closeVideoWin(event:Event) : void
        {
            this.visible = false;
            if (this.video)
            {
                this.video.closeStream();
            }
            return;
        }// end function

    }
}
