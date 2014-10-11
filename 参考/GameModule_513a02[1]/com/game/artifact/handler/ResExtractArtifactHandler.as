package com.game.artifact.handler
{
    import com.game.artifact.control.*;
    import com.game.artifact.message.*;
    import net.*;

    public class ResExtractArtifactHandler extends Handler
    {

        public function ResExtractArtifactHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            ArtifactControl.getInstance().resExtractArtifact(message as ResExtractArtifactMessage);
            return;
        }// end function

    }
}
