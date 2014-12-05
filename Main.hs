{-# LANGUAGE OverloadedStrings #-}
module Main where

import Facebook
import Network.HTTP.Conduit (withManager)
import Control.Monad.IO.Class (liftIO)
import Data.Text (pack, Text(..))
import Control.Applicative ((<$>), (*>))

printUser :: Text -> IO ()
printUser x = withManager . flip runNoAuthFacebookT
            $ getUser (Id { idCode = x }) [] Nothing
            >>= liftIO . (\(Just s) -> print s) . userName

main :: IO ()
main = (pack <$> getLine >>= printUser) *> main