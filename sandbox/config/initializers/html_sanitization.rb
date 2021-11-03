Rails::Html::WhiteListSanitizer.allowed_tags.merge(%w[audio button circle div video path source svg color])
Rails::Html::WhiteListSanitizer.allowed_attributes.merge(
	%w[audio controls source id data-action data-controller data-target data-title data-src data-waveform-target]
)
