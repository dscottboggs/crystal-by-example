# Crystal By Example
![Crystal logo](https://crystal-lang.org/assets/media/crystal_logo.svg)

A collection of examples intended to show how to use Crystal. Based on Mark
McGranaghan's [Go By Example](https://gobyexample.com/) site.

Check it out at [crystalbyexample.tams.tech](https://crystalbyexample.tams.tech/index.html)

## Dependencies
- Crystal (if compiling the renderer or generate-hash script)
- Python3 and python-pygments for syntax highlighting.

## Development
Examples are placed in src/examples/{example name}/{example name}.cr. Shell
commands can also be demonstrated by placin them in a file at
src/examples/{example name}/{example name}.sh. Comments are formatted with
markdown and presented to the left of the block of code they immediately
preceed.

Once your example is written, it needs to be rendered:
 - run `./generate-hash-file {example name}`
 - add your example's name to examples.txt
 - run `./crystal-by-example`

Your example will now be among the other rendered HTML files in `public`.

## Contributing

1. Fork it (<https://github.com/dscottboggs/crystal-by-example/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

 - [Scott Boggs](https://github.com/dscottboggs) - creator and maintainer


## License
This project is based on the Go By Example site by Mark McGranaghan, which is licensed under
a [Creative Commons Attribution 3.0 Unported License](https://creativecommons.org/licenses/by/3.0/),
and as such carries the same license.
