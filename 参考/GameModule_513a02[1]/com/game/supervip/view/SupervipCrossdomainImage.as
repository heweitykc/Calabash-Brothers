package com.game.supervip.view
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;

    public class SupervipCrossdomainImage extends Bitmap
    {
        private var url:String;
        private var loader:Loader;

        public function SupervipCrossdomainImage()
        {
            return;
        }// end function

        public function load(param1:String) : void
        {
            if (this.url == param1)
            {
                return;
            }
            this.url = param1;
            if (this.loader == null)
            {
                this.loader = new Loader();
                this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadComplete);
            }
            else
            {
                try
                {
                    this.loader.close();
                }
                catch (error:Error)
                {
                    try
                    {
                    }
                    this.loader.unload();
                }
                catch (error:Error)
                {
                }
            }
            this.loader.load(new URLRequest(param1), new LoaderContext(true));
            return;
        }// end function

        private function onLoadComplete(event:Event) : void
        {
            bitmapData = (this.loader.content as Bitmap).bitmapData;
            this.loader.unload();
            this.loader = null;
            return;
        }// end function

    }
}
