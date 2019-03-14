module Main where

import Generate
import ClientServerSpec

main :: IO ()
main = generate outputDirectory generatorRoot clientServerApp

