all: statement-example.gif naive-approach.gif solution-approach.gif index-of-pattern.gif first-comparison.gif

%.gif : %.rb animation.rb
	ruby $< <../example10.in

first-comparison.gif: steps.rb animation.rb
	ruby $< <../example10.in

statement-example.gif: statement-example.rb animation.rb
	ruby $<

clean:
	rm -rf *.gif

.PHONY: all clean
